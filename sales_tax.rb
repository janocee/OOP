class Item
	attr_reader :name, :price, :quantity
	def initialize(price, name, quantity)
		@price = price
		@tax_rate = 0.10
		@name = name
		@quantity = quantity
	end

	def calculate_tax
		(@price * @tax_rate).round(2)
	end

	def calculate_total
		@price + calculate_tax
	end
end

class Imported < Item
	def initialize(price, name, quantity)
		super(price, name, quantity)
		@tax_rate = 0.15
	end
end

class Exempt < Item
	def initialize(price, name, quantity)
		super(price, name, quantity)
		@tax_rate = 0
	end
end

class ImportedExempt < Item
	def initialize(price, name, quantity)
		super(price, name, quantity)
		@tax_rate = 0.05
	end
end



class Register
	def initialize
		@items = []
	end

	def stuff
		input = " "
		puts "Please enter the items"
		until input.empty?
		input = gets.chomp.split(" ") 
		return if input.empty?
		input.delete("at")
		
		item = {
			quantity: input[0].to_i,
			name: input[1..-2].join(" "),
			price: input[-1].to_f
		}
		@items << create_item(item)
		end
	end

	def create_item(item)
		if item[:name].include?("imported") && (item[:name].include?("book") || item[:name].include?("chocolate") || item[:name].include?("pills"))
			return ImportedExempt.new(item[:price], item[:name], item[:quantity])
		elsif item[:name].include?("book")
			return Exempt.new(item[:price], item[:name], item[:quantity])
		elsif item[:name].include?("chocolate")
			return Exempt.new(item[:price], item[:name], item[:quantity])
		elsif item[:name].include?("pills")
			return Exempt.new(item[:price], item[:name], item[:quantity])
		elsif item[:name].include?("imported")
			return Imported.new(item[:price], item[:name], item[:quantity])
		else
			return Item.new(item[:price], item[:name], item[:quantity])
		end
	end

	def total_tax
		@items.inject(0) { |sum, item| sum + item.calculate_tax }
	end

	def total
		@items.inject(0) { |sum, item| sum + item.calculate_total }
	end

	def receipt
		@items.each do |item|
			puts "#{item.quantity} #{item.name} : $#{item.price}"
		end
		puts "Sales Tax: #{total_tax}"
		puts "Total: #{total}"

	end

end

grocery = Register.new
grocery.stuff
grocery.receipt
