# 中間記法を逆ポーランド記法に変換する
# 160113

# まず、中間記法を数字と要素ごとに
# 配列に入れる
# ここで、22+3*4みたいなやつもあるので
# １文字ずつ配列に入れると
# ずれちゃう
# 数字か演算子かを判定しなきゃいけない

# まずはかっこなしで


NUMBERS = ["0","1","2","3","4","5","6","7","8","9"]
OPERATORS = ["+", "-", "*", "/"]

=begin

INFIX1 = "2+3*4"
INFIX2 = "22+3*4"

def get_infix_array(chukan)
  number = ""
infix_array = []

last_op_place = -1
for i in 0..chukan.length-1
  puts "#{i}文字目"
# 演算子だったら
if OPERATORS.include?(chukan[i])
  puts "#{chukan[i]}は演算子"
  puts "#{last_op_place+1}文字目から#{i-1}文字目までをpushします"
  # その演算子までの数字をpush
  for j in last_op_place+1..i-1
    number += chukan[j]
  end

  puts "#{number}をpushします"

  infix_array << number
  number = ""

  # その演算子をpush
  infix_array << chukan[i]

  last_op_place = i
else
  puts "#{chukan[i]}は演算子ではないので、次にいきます"
end
puts ""
end

infix_array << chukan[i]

infix_array
end

puts get_infix_array(INFIX2)

=end

infix_array3 = ["2","+","3","*","4"]
infix_array2 = ["5", "+", "4", "-", "3"]
infix_array = ["5", "+", "4", "*", "3", "+", "2", "/", "6"]

rpn_array  = []
waki_array = []

for i in 0..infix_array.length-1
  puts "infix_arrayの「#{i}」文字目を見てみます。"
  #取り出したのが数字だったら
  unless OPERATORS.include?(infix_array[i])
    puts "「#{infix_array[i]}」は数字なので、pushします。"
    rpn_array << infix_array[i]
  #取り出したのが演算子だったら
  else
    puts "「#{infix_array[i]}」は演算子なので、判定が必要です。"
    # waki_arrayに演算子があるとき
    if waki_array.length != 0
      # waki_arrayの右端が+-だったとき
      if   (waki_array[-1]=="+")||(waki_array[-1]=="-")
        puts "「#{waki_array[-1]}」より「#{infix_array[i]}」の方が優先順位が高いので"
        puts "そのままpushします。"
        waki_array << infix_array[i]
      # waki_arrayの右端が*/だったとき
      elsif (waki_array[-1]=="*")||(waki_array[-1]=="/")
        if  (infix_array[i]=="*")||(infix_array[i]=="/")
          puts "「#{waki_array[-1]}」と「#{infix_array[i]}」は優先順位が等しいので"
          puts "そのままpushします。"
          waki_array << infix_array[i]
        else
          rpn_array << waki_array.pop
          waki_array << infix_array[i]
        end
      end
    # waki_arrayに演算子がないとき
    else
      waki_array << infix_array[i]

    end
  end
  puts "rpn_array:#{rpn_array}"
  puts "waki_array:#{waki_array}"
  puts ""
end

until waki_array.length == 0
  rpn_array << waki_array.pop
end
print rpn_array
