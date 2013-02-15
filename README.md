# Ajaila v. 0.0.2 (yet unpublished at RubyGems)
## Datamining Framework
[![Build Status](https://travis-ci.org/mac-r/ajaila.png?branch=master)](https://travis-ci.org/mac-r/ajaila) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/mac-r/ajaila)

Ajaila name is the composition of two words: ajala and agile. According to african mythology "Ajala" is the god of creation, who lives in heaven and makes human faces from clay and chaos. And as far as you most probably know "agile" describes a flexible approach to software development, which expects you to split the workflow into sustainable pieces. Therefore it shouldn't be surprising for you why Ajaila is called like that. We are talking about datamining framework which allows you to follow agile practices.

Why are agile practices so important? Whether you are a software developer or research engineer, there is always someone interested in what you are doing. These people are stakeholders in a project you are working on. Demonstrating results on a regular basis is the crucial point, which allows to succeed. With Ajaila you can conduct R&D, split your datamining project into sustainable parts and show progress within each iteration. 

# Installation 
### Ruby Developer
It's great to solve complex problems in a friendly environment. Are you already familiar with [Bundler](http://gembundler.com/), [RubyGems](https://rubygems.org/) and [RVM](https://rvm.io/)? That's cool! Current Ajaila version supports [Ruby 1.9.3](https://github.com/ruby/ruby). 

Ajaila needs a database to work properly. I decided to use [MongoDB](http://www.mongodb.org/) as a default, because of [ORM](http://en.wikipedia.org/wiki/Object-relational_mapping) ([MongoMapper](http://mongomapper.com/)). [MongoDB](http://www.mongodb.org/) doesn't need [migrations](http://guides.rubyonrails.org/migrations.html) and I find it convenient. Feel free to contribute and make support of other databases.

If you don't have MongoDB install it. 

There is no Ajaila 0.0.2 at RubyGems. Version 0.0.1 is a crap, don't install it. To get an unstable version, which is almost like 0.0.2, you should open the Terminal and clone the repository to your PC (Mac OS / Linux)
```
git clone https://github.com/mac-r/ajaila.git
```

Then build Gem from `ajaila.gemspec`
```
gem build ajaila.gemspec
```

You'll have `ajaila-0.0.2.gem` inside Ajaila folder. This is a newly baked Gem, which can be installed with the Terminal command
```
gem install ajaila-0.0.2.gem
```

After installing all dependencies you'll be able to check if everything went wright. After typing `ajaila` in the Terminal you should get
```
Ajaila Datamining Sandbox v. 0.0.2
```

### Not a Ruby Developer
Set up your environment and learn Ruby. I can post a detailed manual on request. Just create a new issue [here](https://github.com/mac-r/ajaila/issues/new).

# Architecture
The platform consists of two blocks. Among them: Datasets and Sandbox. They exist in the context of Ajaila Environment, which provides everything with a library of methods and allows to generate new instances (selectors, miners, tables, presenters). There is also a Dashboard, which aggregates all information about the particular project (dashboard allows to observe the content of all presenters inside the project).

![Ajaila v.0.0.2 Architecture](https://raw.github.com/mac-r/ajaila-media/master/ajaila_002_architecture.png)

## Datasets vs. Sandbox
Datasets and Sandbox are split according to their usage frequency. 

While [creating a new project](https://github.com/mac-r/ajaila/wiki/Starting-Project) we run selectors only once or at least they are built for that. Selectors parse CSV files and turn static data into dynamic one. 

On the other hand everything in the Sandbox is changed much more often (miners, presenters, tables and even helpers). 

I found this kind of approach valuable and hope that you'll get used to it and appreciate as well.

## Datasets Explained
After creating a new project just put all static files inside `datasets/raw`. For now there is only a CSV format supported within selectors. If you need some other format - just ask me for help by creating a new issue. 

Selectors are the dwellers of Datasets folder. This dudes are very important. Let's look at the Sandbox decomposition: 

`Sandbox` = `Sand` + `Box`

Selectors simply fill an empty box within the data. As soon as `Sandbox` is ready we move to the next step of our workflow. Selectors get left behind and we are making a short bio for each Datasets dweller.

### Datasets Residents
| Residents        | Short Bio | Working With |
| ------------- |:-------------:| -----:|
| CSV Files      | Live inside `datasets/raw`. Keep all the data of the project in the static form. | Manually Placed |
| Selectors      | Require table and file as an input. They know how to parse CSV files. | Generated via Terminal Command |



