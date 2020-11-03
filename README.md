# README
* sub_task_app
インスタグラムのクローンアプリ
写真の投稿、共有、相互フォローイング、お気に入り機能

# versions
  * rails 6.0.3.2
  * ruby  2.7.1

# Database creation
  * pg (1.2.3)

# 追加したgem
  * gem 'font-awesome-rails'
  * gem 'pry-rails'
  * gem 'aws-sdk-s3'
  * gem 'carrierwave'
  * gem 'fog-aws'
  * gem 'image_processing'
  * gem 'mini_magick'
  * gem 'active_storage_validations'
  * gem 'faker'
  * gem 'will_paginate'
  * gem 'bootstrap-will_paginate'
  * gem 'haml-rails'
  * gem 'devise'
  * gem 'uglifier'
  * gem 'jquery-rails'
  * gem 'bootstrap-sass'
  * gem 'omniauth-facebook'
  * gem 'dotenv-rails'

# Usage
  signupして使用。テストアプリのため、devise#confirmableは使用してませんので
  emailは適当な物でログインできます。しかしpasswordを忘れた場合に復帰する手段が
  なくなります。
  facebook-omniauthによるログインも可能です。デフォルトですとユーザーネームが
  facebook登録名になるので適宜登録情報は変更してください。
  写真のアップロードに加え、140文字のコメントを記述可能。
  検索機能が脆弱な為、現状フォロー/フォロワーを探すことが難しいですが、全てのユーザー
  の投稿を見ることが可能です。閲覧制限の機能はありません。
  今後閲覧制限機能、プロフィールのタグ付け機能、画像の加工機能などを拡充し、
  ソーシャリビリティ充実に努めます。

# copyright
  使用している画像は全てフリー素材です。

# Deployment instructions
  https://intense-temple-67818.herokuapp.com/

# Author
* 作成者  yusuke kawachi
* E-mail y.k.trial.serv@gmail.com
 
# License
Copyright (c) 2020, yusuke kawachi
