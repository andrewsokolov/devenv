SSH_PRIVATE_KEY=`cat ~/.ssh/id_rsa`
all:
	docker-compose build --build-arg SSH_PRIVATE_KEY="$(SSH_PRIVATE_KEY)"
