# 単語クイズプログラム
# 160114
# wordlist.csvから読み込んで、出題
# 資格とか英語の勉強に使える

# 変数がiとかlとかひどいので、後で直しときたい
# インデントも！

# 日本語3文字以上7文字以下だとずれない

FILE_NAME = "eitangoSample.csv"

# 出題数
NUM_OF_QUESTIONS = 10

# 選択肢の数
CHOICES = 4

# 出題範囲
START_NUM = 1
END_NUM = 100

# 選択肢の表示のマクロ定義
A = "\ta."
B = "\tb."
C = "\tc."
D = "\td."

def create_test(wordlists)

  NUM_OF_QUESTIONS.times do |q_num|

  # まず正解が何番になるかを決める
  answer_num = rand(CHOICES)

  # 間違った和訳を3つ用意する

  wrong_answer_num1 = rand(NUM_OF_QUESTIONS)
  wrong_answer_num2 = rand(NUM_OF_QUESTIONS)
  wrong_answer_num3 = rand(NUM_OF_QUESTIONS)

  while wrong_answer_num1 == q_num
    wrong_answer_num1 = rand(NUM_OF_QUESTIONS)
  end

  while (wrong_answer_num2 == q_num)||(wrong_answer_num2 == wrong_answer_num1)
    wrong_answer_num2 = rand(NUM_OF_QUESTIONS)
  end

  while (wrong_answer_num3 == q_num)||(wrong_answer_num3 == wrong_answer_num1)||(wrong_answer_num3 == wrong_answer_num2)
    wrong_answer_num3 = rand(NUM_OF_QUESTIONS)
  end

    answer = wordlists[q_num][1]
    x_choice1 = wordlists[wrong_answer_num1][1]
    x_choice2 = wordlists[wrong_answer_num2][1]
    x_choice3 = wordlists[wrong_answer_num3][1]

    puts "(#{q_num+1}) #{wordlists[q_num][0]}"

    case answer_num
    #aが正解のとき
    when 0 then 
      print A, answer,    B, x_choice1, C, x_choice2, D, x_choice3, "\n\n"
    #bが正解のとき
    when 1 then
      print A, x_choice1, B, answer,    C, x_choice2, D, x_choice3, "\n\n"
    #cが正解のとき
    when 2 then
      print A, x_choice1, B, x_choice2, C, answer,    D, x_choice3, "\n\n"
    #dが正解のとき
    when 3 then
      print A, x_choice1, B, x_choice2, C, x_choice3, D, answer,    "\n\n"
    end

  end
end

def main
  wordlists = []
  wordlist_records = []
  wordlist_records_all = []
  open(FILE_NAME) do |file|
  
    while l = file.gets
      wordlist_records_all = l.chomp.split("\r")

      for i in START_NUM-1..END_NUM-1
        wordlist_records << wordlist_records_all[i]
      end

      # 単語帳をランダムに並び替える
      # 出題時にランダムにするとかぶるので、今やっとく
      wordlist_records = wordlist_records.shuffle
    
      # 英単語と意味に分ける
      wordlist_records.each do |record|
        wordlists << record.chomp.split(",")
      end
    end

  end

  create_test(wordlists)

end

main