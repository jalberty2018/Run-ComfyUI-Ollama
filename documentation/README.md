# Run ComfyUI Ollama with Custom nodes

## Environment Variables  

### **ComfyUI Arguments**  

| Token        | Environment Variable     |
|--------------|--------------------------|
| Arguments    | `COMFYUI_EXTRA_ARGUMENTS`|

### **Authentication Tokens**  

| Token        | Environment Variable |
|--------------|----------------------|
| Huggingface  | `HF_TOKEN`           |
| Code Server  | `PASSWORD`           |

### **Diffusion Lora Setup Huggingface**  

| Model Type        | URL (Huggingface or Ollama) |
|-------------------|-----------------------------|
| Ollama model      | `OLLAMA_MODEL[1-6]`         |

## Connection options 

### Services

| Service         | Port          |
|-----------------|---------------| 
| **ComfyUI**     | `8188` (HTTP) |
| **Code Server** | `9000` (HTTP) |
| **SSH/SCP**     | `22`   (TCP)  |
| **Gradio**.     | `7860` (HTTP) |


## Website models

- [Huggingface](https://huggingface.co/)

## Websites software Github

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- [Code server](https://github.com/coder/code-server)
- [Ollama](https://github.com/ollama/ollama)

## Tutorial

- [blog](https://geshan.com.np/blog/categories/ollama/)

### Custom Nodes ComfyUI 

#### Full list

- [awesome-comfyui](https://awesome-comfyui.rozenlaan.site)

#### Installed

- [rgthree](https://github.com/rgthree/rgthree-comfy)
- [login](https://github.com/liusida/ComfyUI-Login)
- [manager](https://github.com/ltdrdata/ComfyUI-Manager)
- [KJNodes](https://github.com/kijai/ComfyUI-KJNodes)
- [Ollama](https://github.com/stavsap/comfyui-ollama)
- [Comfyui-LoopLoader](https://github.com/alessandrozonta/Comfyui-LoopLoader)
- [JoyCaption](https://github.com/judian17/ComfyUI-JoyCaption-beta-one-hf-llava-Prompt_node)
- [StringEssentials](https://github.com/bradsec/ComfyUI_StringEssentials.git)
- [LLM_party](https://github.com/heshengtao/comfyui_LLM_party)
- [VibeVoice](https://github.com/Enemyx-net/VibeVoice-ComfyUI)
- [VLM nodes](https://github.com/gokayfem/ComfyUI_VLM_nodes)

## Gradio

```bash
python gradio/chat_unslopNemo.py
```

Interface available on exposed http port 7860

## Utilites

```bash
nvtop
htop
mc
nano
ncdu
```