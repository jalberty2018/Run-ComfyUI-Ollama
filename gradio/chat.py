import gradio as gr

chat = gr.load_chat("http://localhost:11434/v1/", model="hf.co/saukko/Abliterated-Dolphin3.0-R1-Mistral-24B-GGUF:Q8_0", token="***")
chat.launch(server_name="0.0.0.0")