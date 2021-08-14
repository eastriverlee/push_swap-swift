NAME='push_swap'

$(NAME):
	swiftc *.swift -o $(NAME)

clean:
	rm $(NAME)

.PHONY: clean
