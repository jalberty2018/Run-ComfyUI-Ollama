#!/bin/bash

echo "[INFO] Pod run-comfyui-ollama started"

# ssh scp ftp on (TCP port 22)

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start
fi

# Move necessary files to workspace
for script in comfyui-on-workspace.sh provisioning-on-workspace.sh gradio-on-workspace.sh readme-on-workspace.sh; do
    if [ -f "/$script" ]; then
        echo "Executing $script..."
        "/$script"
    else
        echo "[WARNING]: Skipping $script (not found)"
    fi
done

if [[ ${RUNPOD_GPU_COUNT:-0} -gt 0 ]]; then
    # Start code-server (HTTP port 9000)
    if [[ -n "$PASSWORD" ]]; then
        code-server /workspace --auth password --disable-telemetry --host 0.0.0.0 --bind-addr 0.0.0.0:9000 &
    else
        echo "[WARNING]: PASSWORD is not set as an environment variable"
        code-server /workspace --disable-telemetry --host 0.0.0.0 --bind-addr 0.0.0.0:9000 &
    fi
	
	sleep 5

	# Start Ollama server
    ollama serve &
    
	# Wait until Ollama is ready
    until curl -s http://127.0.0.1:11434 > /dev/null; do
        echo "[INFO] Waiting for Ollama to start..."    
		sleep 5
    done
    echo "[INFO] Ollama server is ready (http://127.0.0.1:11434)."
	
	# Start ComfyUI (HTTP port 8188)
    python3 /workspace/ComfyUI/main.py ${COMFYUI_EXTRA_ARGUMENTS:---listen} &
	
	# Wait until ComfyUI is ready
    until curl -s http://127.0.0.1:8188 > /dev/null; do
        echo "[INFO] Waiting for ComfyUI to start..."    
		sleep 5
    done
    echo "[INFO] ComfyUI server is ready (http://127.0.0.1:8188)."
	
	# Confirmation	
	echo "[INFO] Code Server & ComfyUI & Ollama started"
	
else
    echo "[WARNING]: No GPU available, ComfyUI, Code Server, Ollama not started to limit memory use"
fi
	
# Login to Hugging Face if token is provided
if [[ -n "$HF_TOKEN" ]]; then
    huggingface-cli login --token "$HF_TOKEN"
else
	echo "[WARNING]: HF_TOKEN is not set as an environment variable"
fi

# Download Ollama models
for i in 1 2 3 4 5 6; do
    var="OLLAMA_MODEL$i"
    model="${!var}"
    if [[ -n "$model" ]]; then
        echo "[INFO] Pulling Ollama model: $model"
        if ollama pull "$model" --quiet; then
            echo "[OK] Successfully pulled model: $model"
        else
            echo "[WARNING] Failed to pull model: $model" >&2
        fi
    fi
done

echo "[INFO] Provisioning completed."

# Keep the container running
exec sleep infinity
