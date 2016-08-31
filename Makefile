repository = pyrites/php-build
php_version=5.6.25
all: build

build:
	@docker build --build-arg PHP_VERSION=$(php_version) --force-rm=true -t $(repository):$(php_version) .

rmi:
	@docker rmi $(repository)
