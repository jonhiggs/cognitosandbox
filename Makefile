image=cognitosandbox

build:
	docker build -q -t $(image) .

up: build
	docker run --rm -it $(image) ruby main.rb

irb: build
	docker run --rm -it $(image) irb
