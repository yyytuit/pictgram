$ bundle exec rake db:create

rake aborted!
LoadError: dlopen(/Users/yoshimatsuhiromichi/.rbenv/versions/2.7.0/lib/ruby/gems/2.7.0/gems/mysql2-0.5.3/lib/mysql2/mysql2.bundle, 9): Library not loaded: /usr/local/opt/mysql/lib/libmysqlclient.21.dylib
  Referenced from: /Users/yoshimatsuhiromichi/.rbenv/versions/2.7.0/lib/ruby/gems/2.7.0/gems/mysql2-0.5.3/lib/mysql2/mysql2.bundle
  Reason: no suitable image found.  Did find:
  /usr/local/opt/mysql/lib/libmysqlclient.21.dylib: file too short
  /usr/local/opt/mysql/lib/libmysqlclient.21.dylib: file too short - /Users/yoshimatsuhiromichi/.rbenv/versions/2.7.0/lib/ruby/gems/2.7.0/gems/mysql2-0.5.3/lib/mysql2/mysql2.bundle
/Users/yoshimatsuhiromichi/tweet_app/config/application.rb:7:in `<top (required)>'
/Users/yoshimatsuhiromichi/tweet_app/Rakefile:4:in `require_relative'
/Users/yoshimatsuhiromichi/tweet_app/Rakefile:4:in `<top (required)>'
/Users/yoshimatsuhiromichi/.rbenv/versions/2.7.0/bin/bundle:23:in `load'
/Users/yoshimatsuhiromichi/.rbenv/versions/2.7.0/bin/bundle:23:in `<main>'
(See full trace by running task with --trace)


上記のようなエラーがずっと出た。

mysqlを一度削除(参考URL https://qiita.com/AK4747471/items/36b73edd9d1e666ae0c0)


$ sudo rm -rf /usr/local/mysql
$ sudo rm -rf /Library/StartupItems/MYSQL
$ sudo rm -rf /Library/PreferencePanes/MySQL.prefPane
$ sudo rm -rf /Library/Receipts/mysql-.pkg
$ sudo rm -rf /usr/local/Cellar/mysql*
$ sudo rm -rf /usr/local/bin/mysql*
$ sudo rm -rf /usr/local/var/mysql*
$ sudo rm -rf /usr/local/etc/my.cnf
$ sudo rm -rf /usr/local/share/mysql*
$ sudo rm -rf /usr/local/opt/mysql*
$ sudo rm -rf /usr/local/opt/mysql*


$ brew install mysql@5.7
$ echo 'export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"' >> ~/.bash_profile
$ source ~/.bash_profile
$ brew services start mysql@5.7
==> Successfully started `mysql@5.7` (label: homebrew.mxcl.mysql@5.7)

$ rails _5.2.4_ new pictgram -d mysql

$ bundle exec rake db:create
rake aborted!
LoadError: dlopen(/Users/yoshimatsuhiromichi/.rbenv/versions/2.7.0/lib/ruby/gems/2.7.0/gems/mysql2-0.5.3/lib/mysql2/mysql2.bundle, 9): Library not loaded: /usr/local/opt/mysql/lib/libmysqlclient.21.dylib
  Referenced from: /Users/yoshimatsuhiromichi/.rbenv/versions/2.7.0/lib/ruby/gems/2.7.0/gems/mysql2-0.5.3/lib/mysql2/mysql2.bundle
  Reason: image not found - /Users/yoshimatsuhiromichi/.rbenv/versions/2.7.0/lib/ruby/gems/2.7.0/gems/mysql2-0.5.3/lib/mysql2/mysql2.bundle
/Users/yoshimatsuhiromichi/tweet_app/config/application.rb:7:in `<top (required)>'
/Users/yoshimatsuhiromichi/tweet_app/Rakefile:4:in `require_relative'
/Users/yoshimatsuhiromichi/tweet_app/Rakefile:4:in `<top (required)>'
/Users/yoshimatsuhiromichi/.rbenv/versions/2.7.0/bin/bundle:23:in `load'
/Users/yoshimatsuhiromichi/.rbenv/versions/2.7.0/bin/bundle:23:in `<main>'
(See full trace by running task with --trace)

$ bundle doctor

The following gems are missing OS dependencies:
 * mysql2: /usr/local/opt/mysql/lib/libmysqlclient.21.dylib

$ bundle exec gem uninstall mysql2

Successfully uninstalled mysql2-0.5.3

$ bundle install

An error occurred while installing mysql2 (0.5.3), and Bundler cannot continue.
Make sure that `gem install mysql2 -v '0.5.3' --source 'https://rubygems.org/'` succeeds before bundling.

$ gem install mysql2 -v '0.5.3' --source 'https://rubygems.org/'

$ bundle doctor

The following gems are missing
 * mysql2 (0.5.3)
Install missing gems with `bundle install`

$ bundle install

An error occurred while installing mysql2 (0.5.3), and Bundler cannot continue.
Make sure that `gem install mysql2 -v '0.5.3' --source 'https://rubygems.org/'` succeeds before bundling.

意味なかった。

ここが有効だった。参考URL(https://qiita.com/SAYJOY/items/dd7c8fc7a3647e7ff969)

$ bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib"

$ bundle install

$ rails db:create

Created database 'tweet_app_development'
Created database 'tweet_app_test'

やっと通った。
