# You can capture output by running %!ruby instead of !ruby %

1.upto(100) do |n|
  if (n % 15).zero?
    puts "FizzBuzz"
  elsif (n % 3).zero?
    puts "Fizz"
  elsif (n % 5).zero?
    puts "Buzz"
  else
    puts n
  end
end
