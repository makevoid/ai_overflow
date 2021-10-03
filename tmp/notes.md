to question: How can we translate the Python code `arr = [1, 2, 3]` and `arr.reverse()` in ruby?

you can do `arr = [1, 2, 3]; arr.reverse()`, note that arrays in ruby don't mutate in place if you wanna change something, but if you need the collection mutable in place the best practical choice in ruby is to use an instance of the `
