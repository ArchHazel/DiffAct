docker run --shm-size=8G --gpus all -it \
  --name llm-new \
  -v $(pwd):/workspace \
  pytorch-1.10-cuda11.4-new
