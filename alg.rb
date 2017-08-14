def fib(n)
	if(n<=1)
		return n
	else
		return fib(n-1)+fib(n-2)
	end
end

pfib = Proc.new {|n| fib(n)}

def fac(n)
	if(n<=1)
		return 1
	else
		return n*fac(n-1)
	end
end

pfac = Proc.new {|n| fac(n)}

#pf: proc of function, c: constant f(c) is benchmarked for
def B(pf,c)
	start = Time.now
	pf.call(c)
	return Time.now-start
end

=begin
puts B(pfib,10)
puts B(pfib,15)
puts B(pfib,20)
puts B(pfib,25)
=end

#pf:
def D(pf,c,i)
	distr =[]
	i.times do
		start = Time.now
		pf.call(c)
		distr << Time.now-start
	end
	return distr
end

#x = [D(pfac,10,100),D(pfac,15,100),D(pfac,20,100),D(pfac,25,100),D(pfac,30,100)]
xs=[]
#labels =[]
100.times do |q|
	xs<<D(pfac,q*5,100)
	#labels<<q.to_s
end

#require 'google_visualr'
=begin
tbl = GoogleVisualr::DataTable.new
tbl.new_column('time')
#tbl.add_rows([[1,2,3],[1,2,3]])

opts   = { :width => 20, :height => 240, :legend => 'none' }
@chart = GoogleVisualr::Image::CandlestickChart.new(tbl, opts)
=end

require 'nyaplot'
class Nyaplot::Plot
	def set_xrange(xs)
		@xrange = xs
	end
end
plot = Nyaplot::Plot.new
u=plot.add(:box,*(xs))
plot.width(1400)
#p plot.send("@xrange",["1"]*100)
plot.yrange(Array.new(100){|i| (i).to_s})
p plot.xrange(Array.new(100){|i| (i*5).to_s})
#u.color("green")
u.width(".7")
#plot.labels([*(1..20)])
#plot.bg_color("red")
plot.x_label("n in f(n)")
plot.y_label("Time (t) to completion")
plot.export_html("asdf.html")

=begin
plot = Nyaplot::Plot.new
#p Nyaplot::Diagrams::Box[:width]
#plot.add_with_df(DataFrame.new({hoge:xs}),:box,:hoge)
u = plot.add(:box,*(xs))
plot.width(1600)
#u.color(Nyaplot::Colors.Set3)
#p Nyaplot::Colors.Set3
u.width(1)
plot.export_html("fdsa.html")
=end