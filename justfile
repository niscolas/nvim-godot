docker-run:
  docker run --rm -it --network host niscolas/nvim-godot

docker-build:
  docker image rm niscolas/nvim-godot -f && docker build . --network host -t niscolas/nvim-godot
