# Base image
FROM ls250824/comfyui-runtime:13062025 AS base

# Set working directory
WORKDIR /

# Copy scripts and make them executable
COPY --chmod=755 start.sh onworkspace/comfyui-on-workspace.sh onworkspace/provisioning-on-workspace.sh onworkspace/readme-on-workspace.sh onworkspace/gradio-on-workspace.sh /

# Copy documentation with appropriate permissions
COPY --chmod=644 documentation/README_runpod.md /README.md

# Copy provisioning with appropriate permissions
COPY --chmod=644 provisioning/ /provisioning

# Copy gradio with appropriate permissions
COPY --chmod=644 gradio/ /gradio

# Copy workflows with appropriate permissions
COPY --chmod=644 workflows/ /ComfyUI/user/default/workflows

# Copy default configuration
COPY --chmod=644 comfy.settings.json /ComfyUI/user/default/comfy.settings.json

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Install required Python packages and clone custom ComfyUI nodes
RUN pip3 install --no-cache-dir opencv-python diffusers gradio requests openai && \
    cd /ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git && \
    git clone https://github.com/rgthree/rgthree-comfy.git && \
    git clone https://github.com/liusida/ComfyUI-Login.git && \
    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git && \
    git clone https://github.com/kijai/ComfyUI-KJNodes.git && \
    git clone https://github.com/stavsap/comfyui-ollama.git

# Install requirements for each relevant custom node
RUN pip3 install --no-cache-dir \
    -r /ComfyUI/custom_nodes/ComfyUI-Login/requirements.txt \
    -r /ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite/requirements.txt \
    -r /ComfyUI/custom_nodes/ComfyUI-KJNodes/requirements.txt \
	-r /ComfyUI/custom_nodes/comfyui-ollama/requirements.txt

# Set workspace directory
WORKDIR /workspace

# Expose ports for ComfyUI, code-server, Gradio
EXPOSE 8188 9000 7860

# Start script
CMD [ "/start.sh" ]