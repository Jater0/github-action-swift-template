#!/bin/sh

echo "checking for homebrew updates";
brew update

function install_current {
  echo "trying to update $1"
  brew upgrade $1 || brew install $1 || true
  brew link $1
}

if [ -e "Podfile" ]; then
  echo "installing pod";
  gem install cocoapods;
  pod install;
fi

if [ -e "Gemfile" ]; then
  echo "installing ruby gems";
  gem install bundler --no-document || echo "failed to install bundle";
  bundle config set deployment 'true';
  bundle config path vendor/bundle;
  bundle install --jobs 4 --retry 3 || echo "failed to install bundle";
  instruments -s
fi