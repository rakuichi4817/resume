# 履歴書 LaTeX テンプレート

LuaLaTeX用のA4履歴書テンプレートです。項目や文章が増えた場合は、文字を縮めずに後続ページへ自動的に続きます。

- `resume.example.tex`: Git管理する匿名サンプルデータ。
- `../../private/resume/resume.tex`: Git管理外の本番データ。
- `resume.sty`: 寸法、フォント、罫線、写真欄、改ページ処理。
- `resume.example.pdf`: サンプルのビルド結果（Git管理外）。

## ビルド

プロジェクトルートで実行します。

```sh
mise run build:resume
mise run rebuild:resume # ソースに変更がなくても日付を更新
```

この`templates/resume/`内で直接ビルドする場合は`latexmk -lualatex resume.example.tex`を使えます。本番用は`private/resume/`から`TEXINPUTS=../../templates/resume//: latexmk -g -lualatex resume.tex`を実行します。Dockerでのビルド手順は[ルートREADME](../../README.md)を参照してください。

LuaLaTeX専用です。pdfLaTeXやTectonicではビルドできません。Debian/Ubuntuでは次のパッケージが必要です。

```sh
sudo apt install latexmk texlive-luatex texlive-lang-japanese texlive-pictures fonts-ipaexfont fonts-urw-base35
```

補助ファイルだけを削除する場合は対象のディレクトリで`latexmk -c resume.example.tex`（本番用なら`resume.tex`）、生成PDFも削除する場合は`latexmk -C`を使います。参照PDFは削除されません。

## 再現している配置

- 左19mm、右14.5mm、上13mmの余白。帳票幅176.5mm。
- 外枠1pt、内罫線0.4pt。ふりがな、電話/FAX、最寄り駅の区切りは点線。
- 氏名・生年月日・携帯電話・メールと、住所に接続した電話/FAX欄。
- 学歴・職歴・資格は「西暦／月／内容」の3列。学歴の入学・卒業等は内容列内で右寄せ、職歴・資格の状態は名称の後ろに記載。
- 経歴表末尾に既定で空欄12行、資格表末尾に空欄2行を追加。各ページの行数や資格欄の開始位置は入力内容に応じて変わります。
- 最寄り駅・扶養家族数・配偶者・配偶者の扶養義務を4セルで表示。選択値を丸囲み。
- 趣味・特技32.5mm、自己PR28mm、本人希望28.5mmを最低高とする自由記入欄。

IPAexゴシック／IPAex明朝／C059（Century Schoolbook系）を使用します。写真は別ファイルを使用します。

## 個人情報

通常は`private/resume/resume.tex`の`\renewcommand`だけを編集します。記入日はビルド日の動的表示です。年齢は自動計算しないため、提出前に確認してください。以下は入力例であり、既存の個人情報は変更していません。

```tex
\renewcommand{\ResumeDate}{\number\year 年　\number\month 月　\number\day 日}
\renewcommand{\Age}{31}         % 実際の提出日時点の年齢を確認
\renewcommand{\Gender}{男}       % 男 / 女 / 空欄（丸を付けない）
\renewcommand{\PostalCode}{000-0000}
\renewcommand{\ContactAddress}{同上}
\renewcommand{\NearestStation}{サンプル線　サンプル駅}
\renewcommand{\Dependents}{0}
\renewcommand{\Spouse}{無}       % 有 / 無 / 空欄
\renewcommand{\SpouseSupport}{無}
```

連絡先が異なる場合は`\ContactPostalCode`、`\ContactKana`、`\ContactAddress`を設定します。住所横の電話/FAXは`\HomePhone`、`\HomeFax`、`\ContactPhone`、`\ContactFax`で編集できます。未指定なら参照と同じ空欄形式になります。

```tex
\renewcommand{\HomePhone}{（000）\\[2mm]000-0000}
```

## 写真

本番用は`private/resume/`に`photo.jpg`があれば、縦40mm・横30mmの領域に縦横比を保って中央配置します。別名やPNG/PDFを使う場合は`\PhotoFile`を変更してください。ファイルがない場合や空指定の場合は写真貼付欄を表示します。領域を満たすには縦横比4:3の画像を用意してください。自動トリミングは行いません。

## 学歴・職歴・資格

既存の入力マクロをそのまま使えます。記載順に追加してください。

```tex
\ResumeEducationEntry{2024}{4}{学校名}{入学}
\ResumeEmploymentEntry{2025}{4}{会社名}{入社}
\ResumeEmploymentNote{部署名・補足説明}
\ResumeEmploymentCurrent
\ResumeQualificationEntry{2025}{6}{資格名}{合格}
```

`\ResumeEmploymentCurrent`は「現在に至る」を追加します。「学歴」「職歴」「以上」および末尾の空欄は自動で付きます。

経歴表末尾の空欄12行は既定値です。項目が多く2ページを超える本番用履歴書では、本文を削ったり文字を縮めたりせず、`private/resume/resume.tex`で`\renewcommand{\ResumeCareerBlanks}{\ResumeSixBlanks}`と指定すると6行に変更できます。変更後はビルドしてページ数と表示を確認してください。

表は`longtable`で組版し、長い名称は内容列で折り返します。項目が増えた場合は行の境界で改ページし、各ページに列見出しと外枠を再表示します。経歴表全体の後に資格欄が続くため、データ増量時は資格欄の開始位置も下がります。

## 自由記入欄

```tex
\ResumeHobbies{ジョギング\\サッカー観戦}
\ResumePR{自己紹介の第一段落。\par 第二段落。}
\ResumeRequest{貴社規定に従います。}
```

`\\`で改行、空行または`\par`で改段落できます。短文でも最低高を確保し、長文なら枠が伸びます。残りのページに収まらない場合は本文を行単位で分割し、続きのページにも枠と欄名を表示します。改段落のない長文も分割できます。

## 制約

- 個人情報欄と家族欄は参照に合わせた固定寸法です。極端に長い氏名・ふりがな・メール等は枠内に収まるかPDFで確認してください。
- 表の1項目自体をページ間で分割することはできません。1ページを超えるほどの補足は複数の`\ResumeEmploymentNote`に分けるか、自由記入欄に記載してください。
- 自由記入欄は通常の文章を想定しています。ページより大きい画像・表・`minipage`等の分割できない要素や脚注には対応していません。
- `%`、`&`、`_`などのLaTeX特殊文字は`\%`、`\&`、`\_`のように記述してください。
