# React + (Javascript || CoffeeScript) + Bower スタータキット @masuidrive

https://github.com/masuidrive/react-starterkit

　Reactを簡単に始めるには、[jsfiddleのReactサンプル](http://jsfiddle.net/reactjs/69z2wepo/)や[公式スタータキット](http://facebook.github.io/react/docs/getting-started.html)を使う方法があります。

　両方ともブラウザだけで実行でき手軽なのですが、ソースファイルを分割しrequireで読み込んだり、ライブラリを使ったり、SaSSを使うようなコンパイルが必要なモノには対応する事ができません。

　実際にReactで何かを作るときには、コンパイル環境を構築する必要があるのですが、その方法は色々あり結構複雑です。

　私もReactで本格的にアプリを作ろうと思ったとき、WebPackやGulpなど新しいツールキットがたくさんあり、どうやって構築していいのか悩みました。

　色々試してみた結果、BrowerifyとGulpを中心にnpmを使って環境構築し、Reactで使うライブラリはBowerで管理するのが良さそうと言うことに落ちつきました。

　そこで、なるべくシンプルな形でReactを始められるよう、環境構築部分をまとめてこのパッケージを作ってみました。


## 環境構築

　Windowsだったり、Linux/OSXでもローカルにNode入れたくない人向けにVagrant環境も用意しました。

　と言ってもWindowsのVagrantは触ったことないので、おかしいところがあったらPull Requestよろしくお願いします。

　テストに付いては自分でもまだ方針が決まっていないので放置されています。


## Starter kitのダウンロード

　gitをお使いの方は、`git clone https://github.com/masuidrive/react-starterkit.git`してください。

　gitのない方は、[master.zip](https://github.com/masuidrive/react-starterkit/archive/master.zip)をダウンロードして適当な所に解凍して下さい。


## Nodeのインストール

　ローカルに[Nodeをインストール](http://nodejs.org/download/)するか、Vagrantを使う事ができます。

　Vagrantを使う場合は、[Vagrant本体](https://www.vagrantup.com/)と[VirtualBox](https://www.virtualbox.org/)をインストール後、下記の様に実行します。
`/vagrant`にカレントディレクトリがマウントされているので移動してください。

```
host$ vagrant up && vagrant ssh
〜〜 待つ 〜〜
/vagrant$ cd /vagrant
```


## パッケージを導入

　下記のコマンドを実行すると開発に必要なパッケージが導入されます。

```
/vagrant$ rm -Rf node_modules bower_components
/vagrant$ npm install && ./bin/bower install
```

　もし下記の様なメッセージが出たら「y」キーを押して下さい。

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

## React解説

- [Ajaxを劇的に簡単にするReact.js – @masuidrive blog](http://blog.masuidrive.jp/2015/03/03/react/)


## 配布用ビルド

　`./bin/gulp dist:build`を実行すると、 JavascriptとCSSのsourcemapsを取り除いてminifyして`./dist`にコピーします。


## CM
トレタでは、業務急拡大中につきRuby/フロントエンド/インフラエンジニアが足りなくてとっても困っています！
コード書くことが好きなエンジニアを募集しています。

興味のある方は、下記URLからご応募お待ちしています！
https://www.wantedly.com/projects/11460
