all: build stop start

build:
	docker build -t t4skforce/nextcloud-full:latest .

stop:
	docker stop nextcloud-full || true

start:
	docker run -it --rm --name nextcloud-full t4skforce/nextcloud-full:latest

clean:
	docker rm nextcloud-full || true
	docker rmi t4skforce/nextcloud-full:latest || true
