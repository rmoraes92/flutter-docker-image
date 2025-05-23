git_release_version=$(shell git branch --show-current | sed -E 's/release\/([0-9]+\.[0-9]+(\.[0-9]+)?)/\1/')

docker_img_name=rmoraes92/flutter
docker_img_tag=latest
docker_img_full_tag=$(docker_img_name):$(docker_img_tag)
docker_img_archive_name=flutter-$(git_release_version).tar

sdk_version=$(git_release_version)
base_url_lnx_sdk=https://storage.googleapis.com/flutter_infra_release/releases/stable/linux
sdk_archive=flutter_linux_$(sdk_version)-stable.tar.xz
sdk_folder=flutter

echo_git_release_version:
	@echo $(git_release_version)

assets:
	mkdir -p assets

assets/$(sdk_archive): assets
	cd assets && curl -O $(base_url_lnx_sdk)/$(sdk_archive)
	touch $(sdk_archive)

assets/flutter: assets/$(sdk_archive)
	tar xf assets/$(sdk_archive) -C assets/
	mkdir -p assets/flutter

dist:
	mkdir -p dist

dist/$(docker_img_archive_name): dist
	docker build -t $(docker_img_full_tag) . --progress plain
	docker save $(docker_img_full_tag) > dist/$(docker_img_archive_name)
	touch dist/$(docker_img_archive_name)

build: assets/flutter dist/$(docker_img_archive_name)

clean:
	-rm -rf dist/*
	-rm -rf assets/*

push:
	docker push $(docker_img_full_tag)
