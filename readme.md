# React + (Javascript || CoffeeScript) + Bower スタータキット @masuidrive

## 環境構築

Reactの開発環境は主にNodeで構築されています。

## Starter kitのダウンロード

gitをお使いの方は、`git clone https://github.com/masuidrive/react-starterkit.git`してください。

gitのない方は、[master.zip](https://github.com/masuidrive/react-starterkit/archive/master.zip)をダウンロードして適当な所に回答して下さい。


## Nodeのインストール

ローカルに[Nodeをインストール](http://nodejs.org/download/)するか、Vagrantを使う事ができます。

Vagrantを使う場合は、[Vagrant本体](https://www.vagrantup.com/)と[VirtualBox](https://www.virtualbox.org/)をインストール後、下記の様に実行します。
`/vagrant`にカレントディレクトリがマウントされているので移動してください。

```
host$ vagrant up && vagrant ssh
〜〜 待つ 〜〜
/vagrant$ cd /vagrant
```

注) 必要なboxファイルは12MB程度と小さいモノを使っています。


## パッケージを導入

下記のコマンドを実行すると開発に必要なパッケージが導入されます。

```
/vagrant$ rm -Rf node_modules bower_components
/vagrant$ npm install && ./bin/bower install
```

下記の様なメッセージが出たら「y」キーを押して下さい。

```
[?] May bower anonymously report usage statistics to improve the tool over time?
```

開発環境のパッケージはnpm、クライアント側のライブラリはbowerで管理しています。


## 実行

下記のコマンドを実行後、ブラウザで[http://localhost:8000]を開いて下さい。

```
/vagrant$ ./bin/gulp dev
[07:29:25] Finished 'dev' after .... ← 出るを待つ
```

下記の様なエラーが出たら、`node_modules`と`bower_components`を削除して、`npm install`からやり直してください。

```
Error: `libsass` bindings not found. Try reinstalling `node-sass`?
```

## ソースコード

`./app`以下にソースコードが入っています。

2月中には、ここの拡充とブログ書きます。
