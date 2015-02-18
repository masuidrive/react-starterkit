# React + (Javascript || CoffeeScript) + Bower スタータキット @masuidrive

## 環境構築

Reactの開発環境は主にNodeで構築されています。

## Nodeのインストール

ローカルに[Nodeをインストール](http://nodejs.org/download/)するか、Vagrantを使う事ができます。

Vagrantを使う場合は、[Vagrant本体](https://www.vagrantup.com/)と[VirtualBox](https://www.virtualbox.org/)をインストール後、下記の様に実行します。
`/vagrant`にカレントディレクトリがマウントされているので移動します。

```
host$ vagrant up && vagrant ssh
〜〜 待つ 〜〜
/vagrant$ cd /vagrant
```

## パッケージを導入

下記のコマンドを実行すると開発に必要なパッケージが導入されます。

```
rm -Rf node_modules bower_components
npm install && ./bin/bower install
```

開発環境のパッケージはnpm、クライアント側のライブラリはbowerで管理しています。

## 実行

下記のコマンドを実行後、ブラウザで[http://localhost:8000]を開いて下さい。

```
./bin/gulp dev
```

下記の様なエラーが出たら、`node_modules`と`bower_components`を削除して、`npm install`からやり直してください。

```
Error: `libsass` bindings not found. Try reinstalling `node-sass`?
```
