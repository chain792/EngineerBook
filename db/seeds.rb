programming = Category.create(name: 'プログラミング')
programming.children.create(
  [
    { name: 'Ruby' },
    { name: 'PHP' },
    { name: 'JavaScript' },
    { name: 'Python' },
    { name: 'C' },
    { name: 'C#' },
    { name: 'C++' },
    { name: 'Java' },
    { name: 'HTML' },
    { name: 'CSS' },
    { name: 'その他' },
  ]
)

computer_technology = Category.create(name: 'コンピュータテクノロジー')
computer_technology.children.create(
  [
    { name: 'コンピュータサイエンス' },
    { name: 'データベース' },
    { name: 'ネットワーク' },
    { name: 'インフラ' },
    { name: 'AI・機械学習' },
    { name: 'ハードウェア' },
    { name: 'その他' },
  ]
)

others = Category.create(name: 'その他')
others.children.create(
  [
    { name: '小説・ノベルズ' },
    { name: '教養' },
    { name: '趣味' },
    { name: 'コミック・雑誌' },
    { name: 'その他' },
  ]
)

User.create(name: 'test', email: 'test@example.com', password: 'test', password_confirmation: 'test')