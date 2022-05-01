# Promela Challenges

## Install spin

```bash
brew install spin
```

VSCode extension: `Promela`

## Monkeys Typewriters

Task made by Higher School of Economics | Irina A. Lomazova & Roman Nesterov

Model a system with 26 typing monkeys and 1 human reviewer.
1. Each monkey has its own button, which once pressed, sends a lower-case character (‘a’..’z’) to the reviewer. A monkey can press its button at any time, until the experiment is over.
2. The reviewer check the incoming sequence of characters, one by one, against the quote “to be or not to be” (spaces are ignored). As soon as there is a match, the reviewer stops the experiment.
Organize interactions among monkeys and the reviewer using a global channel. Formulate an LTL property such that a counter-example found by Spin is a sequence of steps leading to the match with the quote. Find and demonstrate this sequence.