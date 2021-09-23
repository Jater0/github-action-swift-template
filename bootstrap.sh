#! /bin/sh

echo "checking for homebrew updates";

brew upgrade

function install_current {
  echo "try to update $1"
  brew upgrade $1 || brew install $1 || true
  brew link $1
}

if [ -e "Gemfile" ]; then
  echo "installing ruby gems";
  gem install bundler --no-document || echo "failed to install bundle";
  bundle config set deployment "true";
  bundle config path vendor/bundle;
  bundle install || echo "Failed to install bundle";
if