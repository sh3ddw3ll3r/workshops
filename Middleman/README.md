# Middleman

[Middleman](http://middlemanapp.com/) is a static site generator using all the shortcuts and tools in modern web development. It is a ruby (sinatra) application. Setup instructions are included in INSTRUCTIONS.md.

You goal is to transform the installation instructions into one or more Chef recipes that will install and initialize the application.

## Objectives

The goal is to transform the installation instructions into one or more Chef recipes that will install and initialize the Middleman application.

After successfully completing this workshop, you will be able to:

* Install and configure the Middleman site using Chef.
* Use the [Chef Documentation](http://docs.chef.io) to identify and use resources that will help you model the desired state of your infrastructure.
* Include [guards](https://docs.chef.io/resources.html#guards) in Chef resources.

## Pre-requisites

Before beginning you will need:

* Some experience using Chef such as:
  * completing the exercises on [Learn Chef](http://learn.chef.io/tutorials)
  * completing a Chef Essentials workshop
  * real-world experience working with Chef
* Chef DK or chef-client installed on your local workstation to develop and test your Chef code.
* A text editor (i.e. Atom, SublimeTest, VisualStudio Code)
* A version control system (i.e. Github)
* A virtual machine running Ubuntu 12.04 or later

## Instructions

* Use the ChefDK and text editor to develop and test your Chef code on your local workstation.
* Use the instructions provided in the file `INSTRUCTIONS.md` to construct your Chef cookbook that mirrors the installation instructions. Use the Chef Resources reference to find the most appropriate Chef Resources to use for each task. [Chef resources reference][https://docs.chef.io/resources.html]

* There are a couple of ways that you can write, test and run your cookbook.
  * Using the steps outlined [here](https://learn.chef.io/tutorials/local-development/ubuntu/), write and test your cookbook locally using Vagrant + Virtualbox
  * Use your Ubuntu 12.04 (or later) virtual machine. Write your cookbook in vim, nano or emacs, and run `chef-client` in `--local-mode`.


## Completion Criteria

Store your work in a Github repository.

You should be able to explain the following:

* Steps taken to achieve the end result.
* Build and test process of Chef code.
* Tools used in the process.

You'll know this project is complete when:

* Your Chef cookbook successfully compiles and executes on a target node
* You can interact with the middleman site in a browser.
* You can run chef-client multiple times without failures.
* Your source code repository shows the history of your work.

## Next steps

You can expand on this project a number of ways including:

* Testing
  * Add [Inspec](http://inspec.io/) tests
  * Add static code analysis using [Rubocop](https://github.com/bbatsov/rubocop) and [Food Critic](foodcritic.io)
  * Add [ChefSpec](http://sethvargo.github.io/chefspec/) unit tests

* Utilize community cookbooks inside of your cookbook [Community Cookbooks](http://supermarket.chef.io)

The community has created cookbooks that accomplish similar goals. Select a group of resources, recipe, or cookbook and replace it with the equivalent community cookbook.
