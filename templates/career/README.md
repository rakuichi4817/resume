# 職務経歴書 LaTeX テンプレート

A4・白黒・ゴシック体の職務経歴書テンプレートです。本文量に応じて改ページします。

- `career.example.tex`: Git管理する匿名サンプルデータ。
- `../../private/career/career.tex`: Git管理外の本番データ。
- `career.sty`: フォント、余白、見出し、3列表と自動改ページ。
- `career.example.pdf`: サンプルのビルド結果（Git管理外）。

## ビルド

プロジェクトルートから:

```sh
mise run build:career
mise run rebuild:career # 日付の強制更新
```

この`templates/career/`内では`latexmk -lualatex career.example.tex`を使えます。本番用は`private/career/`から`TEXINPUTS=../../templates/career//: latexmk -g -lualatex career.tex`を実行します。依存パッケージとDockerでのビルド手順は[ルートREADME](../../README.md)を参照してください。

## 公開用と本番用

`career.example.tex`は架空の会社・案件・実績だけを含む公開用サンプルです。実在の勤務先、顧客、案件、人数、社内情報、URLなどは、Git管理外の`private/career/career.tex`へ記入してください。

## 基本編集

日付は`\CareerDate`でビルド日を表示します。固定したい場合は、`private/career/career.tex`の定義を`\newcommand{\CareerDate}{2026年9月7日}`等に変更してください。氏名は`\CareerName`を編集します。

```tex
\CareerSection{セクション名}
通常の文章。空行または\par で段落を分けられます。
\CareerHeading{小見出し}
\CareerBullet{箇条書きの本文}
\CareerBullet[1]{字下げした補足}
\CareerBullet[2]{さらに字下げした補足}
```

## 会社・案件追加

会社は`\CareerCompany{会社名}{在職期間}{所属}`で追加します。その下に必要な数だけ`CareerProject`を並べます。引数は順に「期間」「案件名」「右列の情報」、環境内が中央列の本文です。

```tex
\CareerCompany{会社名}{開始年月～終了年月}{部署名}
\begin{CareerProject}{開始年月\par ～\par 終了年月}
  {案件名}
  {\CareerField{人数}{人数を記入}
   \CareerField{役割}{役割を記入}
   \CareerField{利用言語}{言語を記入}
   \CareerField{利用技術・開発ツール}{技術を記入}
   \CareerBullet{ツールを記入}}
\CareerHeading{【プロジェクト概要】}
概要を記入。
\CareerHeading{【担当業務】}
\CareerBullet{担当業務を記入。}
\CareerHeading{【成果・貢献】}
\CareerBullet{確認できる成果を記入。}
\end{CareerProject}
```

## レイアウトと制約

- 余白は左右15mm、上下18mm。IPAexゴシックとNimbus Sansを使用し、日本語太字は擬似ボールドです。原本の字形と完全一致ではありません。
- 案件は期間・業務内容・人数等の3列。薄いグレーの列見出しと罫線を各案件・継続ページに表示します。
- 各列を独立した段落として行単位で分割します。案件全体だけでなく、単一の長い段落や箇条書き、右列の長い技術一覧もページをまたげます。継続ページでは消費済みの期間・右列は空欄になります。
- 手動の`\newpage`は通常不要です。本文量によりページ数や論文・自己PRの開始位置も変わります。
- 案件内は通常の文章向けです。脚注、フロート、ページより大きな画像・表・`minipage`、分割不能な長い数式には対応していません。長いURLや識別子も出力確認が必要です。
- `%`、`&`、`_`は`\%`、`\&`、`\_`と記述します。URLには`\url{https://example.com/}`を使えます。
