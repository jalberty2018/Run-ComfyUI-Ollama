#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/gradio ]]
then
	mv /gradio /workspace
	# Set permissions right for directory
    chmod -R 777 /workspace/gradio
else
	rm -rf /gradio
fi

# Linking
ln -s /workspace/gradio /gradio

