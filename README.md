#履歴から新聞を作りたい

##研究概要1
インターネットが普及し始めて15年近くが立つ。
ブラウザはどんどんと進化していくが、閲覧履歴の表示方法は昔から変わっていない。
ブラウザの閲覧履歴にはユーザーに関するデータが多く含まれており、これをこのままにしておくのはもったいない。 (に利用する機会を逃している)


本研究ではブラウザの閲覧履歴を、一画面にWeb新聞のように表示することで、
閲覧履歴をユーザーのライフログとして利用することを目的としている。

本研究において重要な点は、閲覧履歴をユーザーのデータとして持たない点にある。
閲覧履歴は極めて重大なユーザーの個人情報であり、
それをすべて収集し解析することは、個人情報の侵害に当たる可能性が大きい。
（ユーザーごとに似ているユーザを解析して、ほかのユーザーがみたページを推薦するなど）
だからそういうのをあんまり解析しないで重要ページを抽出するよー


##研究概要2
近年、Gunosyやpaper.liなどの、Webページを推薦したり、まとめのページを作るようなサービスが増えている。
それらのWebページはTwitterやFaceBookでシェアされた少ないページ郡の中、もしくは他人のシェアした情報などから抽出されている。
しかし、既存のサービスはユーザの限られた情報しか使っていないため、本当に自分にマッチした情報を得るには不完全である。

そこで本研究では、ブラウザの閲覧履歴に注目した。
ブラウザの閲覧履歴はユーザー特有のものであり、ユーザが実際に興味を持って見たページの分析することができると考えられる。
本研究ではブラウザの閲覧履歴から、今後興味を示して実際に見るであろうページの予測するシステムを作るための前段階として、
ブラウザの閲覧履歴を一画面にまとめ、ユーザーのライフログとして記録していくシステムを提案する。


##目的
* 知りたかったページ 　検索したページ
* 自分の過去を思い出す
* ライフログとしての記録

##1.記事の区切り方、レイアウト
* ある手法からいろんなレイアウトを作成し、**SAで評価の良いもの**を選んでいく
* とりあえず現在はTreemapを使っている


####手法1 全探索的に二分割していく(Squarified Treemaps)

####手法2 正方形でレイアウトする(手法1の改良)
○ 綺麗に配置できる  
○ 簡単  
☓ 決め打ちで書かなければいけないところが多い  
☓ あまり枠の大きさの種類を作ることができない  
☓ レイアウト優先になり、重要度を綺麗に分けづらい 
 
####手法3 力学モデルでレイアウト
☓ 綺麗に配置できるかわからない


###評価関数
- 黄金比に近いか
- 同じサイズが近くに配置されてるか(5と4が近くに配置されてる必要はない)


###設定するもの
- 横,横の最大ストリップ数
- 左右上下の重み付け
- 最低限の大きさ
 
###枠の大きさの設定
- 何種類もない方がいい？
- 


##2.記事の選び方
###とれる情報
1. その日に検索したキーワード
2. 履歴
3. ページタイトル



####どんなページを選ぶか(重要度の決定の仕方)
#####1.その日初めて訪れたページ優先
* １週間のうちで初めて訪れたページ
* 何度もアクセスしない(3回までくらい?)
* 検索したキーワード

#####2.なんか他
* js でクリック監視
* 滞在時間などから、その人にとっての重要なページを見つける

#####検索にでてきたキーワードをタイトルにもつページの重要度を高く

####記事の排除の仕方  現在の状態
* タイトルがない
* png/jpgなどの画像データ/音楽データ
* youtube他動画サイト
* 同じドメインからはひとつ
* タイトルに同じキーワードが入ってたら少し順位を下げる
* 同じタイトルはとらない 
* 

##3.記事データの抽出
* 画像抽出->画像データどこにおく (データベース作る?)
* ogタグで画像だけとる
* 要約抽出
* **本文抽出** 
	[Webstemme](http://www.unixuser.org/~euske/python/webstemmer/index-j.html)
* 

##4.本文抽出アルゴリズム
1. 一番上のarticle
2. ある程度句読点の多いブロック要素で一番先頭にあるもの
3. タイトルに含まれるキーワードを重視する


##アンケートを考える

####前提
画像や本文は抽出する予定

####目的
- 開発優先順位
- 5人くらいにやってもらう
- 就活用
- 


###各記事に対して
1. 人とシェアしたいと思うような記事ですか？
3. 自分がもう一度読みたい、復習したいと思う記事ですか？
4. この記事は必要ないと思いますか

###全体に対して
4. 今日を振り返ることができるような内容でしたか？
5. 4.で足りないと思うページ、要らないと思うページを教えてください

####あなたの一日を履歴で振り返るとして、どんな記事が選出されてほしいか
* その日初めて訪れたページ
* よく訪れるページ
* その日に検索したキーワードと関係のあるページ
* その日によく訪れたカテゴリのページ

#####現在のページ選出のしかた
1. ここ2,3ヶ月のうち初めて訪れたページ
2. 3その日訪れた回数が3回



##前回のアンケート結果
####表示してほしいページ
- Youtube /現在除外中
- 推薦があったらいいな / ちょっと別問題かも
- あるページからリンクされていて、自分ではキーワードとして検索しなそう＆リンク元のタイトルのみからはリンク先の情報が推定できなそうなページ
- もっといろんな（関連があまりない）ページがそれぞれ表示されて欲しかったです。

####表示されたくないページ
- ニュースサイトの「指定されたURLは存在しません」というページ
- Google Scholar のキーワード検索結果一覧のページ(表示する必要がないというより、右の検索キーワードみたいな感じでは残っていて欲しいかも) 
- 関連のあるページが別に表示されていたので、そこは1つでいいなと思いました。

####こうなったらいいなと思うところ
- 他のページを開かないうちに(履歴が新しく溜まってないうちに)リロードをおした時にも違うページが表示されたりタイルの形が変わったりすると、より弄ってみたいと思わせそうだと感じました。
- ジャンル別に色が別れるなど / 難しそう・・・
- 一度に表示する数によると思うけれど、一覧表示する数が少ないのであれば、同じタイトル・キーワードのページはどれか代表1つでいいかもと思います。
- 表示するときの配置を新聞がテーマだったら新聞みたいな配置になったら面白いかなと思いました。


####自分の意見
- History-Paperのページが表示されるのはよくない。。。
- "検索結果"みたいなページはない方がいい / 通販、論文



####ゼミ
- Strip treemap
- Orderd treemap (並べたい順
- どこが見られているのか 視線追跡
- バランス的に良いか -> レイアウト 研究
- 横長になる
- はてなブックマークのエントリ数



##12/13 
1. treemap分ける
2. レイアウトについて調べてみる 根拠がほしい
3. Vis, Webインテリジェンス&インタフェース, wi2, EC, どの
4. http://www.entcomp.org/sig/2013/index.php?page=ForSubmitters
5. http://youngjump.jp/voice/

