docker: Dockerfile
	sudo docker build . -t quay.io/quamotion/qemu:latest
	sudo docker image ls --format "{{.ID}}" quay.io/quamotion/qemu:latest > docker
