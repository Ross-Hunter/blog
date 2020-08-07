---
title: TypeScript + Vue + Prettier + Eslint - My Sanity = Great Linting!
date: 2019-09-05
layout: post
tags: code, js, vue
cover: test.jpg
id: 22
---

I think the only thing I hate more than inconsistent code style, is wasting time during code reviews talking about inconsistent code style. I expect you to have taken the time to already format your code by the time it is brought to code review. I would even go as far as saying presenting poorly formatted code for review is disrespectful, and I will think less of you if you do it.

For JavaScript formatting I'm a huge fan of [Eslint](https://eslint.org/) and [Prettier](https://prettier.io/). The best way to use these tools together is through [prettier-eslint](https://github.com/prettier/prettier-eslint). Prettier is a more powerful code formatter, and Eslint is a more flexible and configurable linter.

The configurability of these tools can sometimes be a stumbling block, especially when you add in Vue and Typescript.

# Install the things!
`yarn add prettier-eslint prettier-eslint-cli @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-config-airbnb @vue/eslint-config-standard --dev`
