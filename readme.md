# React + (Javascript || CoffeeScript) + Bower スタータキット

## install

開発環境のパッケージはnpm、クライアント側のライブラリはbowerで管理しています。

nodeの最新版を入れて、下記のコマンドを実行してください。

```
npm install
./bin/bower install
```

## 実行

```
./bin/gulp dev
open http://localhost:8000
```

下記の様なエラーが出たら、`node_modules`と`bower_components`を削除して、`npm install`からやり直してください。

```
Error: `libsass` bindings not found. Try reinstalling `node-sass`?
```
