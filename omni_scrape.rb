require "omni_scrape/version"
module OmniScrape
    
##########################################################################################
    
def CrawlScrape(url, depth, sub_url)
    if (depth<0)
        depth=0
    end
    s_depth = depth
    #open the starting page
page = Nokogiri::HTML(open(url))
    #collect all of the links from the page
links= page.css('a')

    #initialize variables
refarr=[]
titlearr=[]
titles =[]
hrefs = []
x=0
    #add title and href to arrays for each link
links.each do |link|
			if(link['title']!=nil && link['title']!="" &&link['href']!=nil && link['href']!="")
			# puts x
			# puts (link['title'].split.join)
			# x+=1
			titles.push((link['title']).split.join)
			hrefs.push((link['href']).split.join)
				
			end
			
    end
	inc=0
    #transfer links to other array
	while(!hrefs.empty?)
		value= hrefs.pop
		puts value
		refarr.push(value)
		refarr[inc]
		inc+=1
	end
	inc=0
    #transfer titles to other array
    while(!titles.empty?)
       value = titles.pop
	   puts value
	   titlearr.push(value)
	   puts titlearr[inc]
	   inc+=1
	end
    #setup for recognition of the end of the array
        refarr.push("-")
  
    #create folder for storing current set of scraped pages
    g_depth = s_depth
    while (g_depth>-1)
    if (Dir.exist?('./pages'+g_depth.to_s))
    else Dir.mkdir('./pages'+g_depth.to_s)
end
        g_depth =g_depth-1
    end
    
    #in each link 
for i in 1..titlearr.length
    if(refarr[i]!="-")
        #evaluate whether link is internal or external
        if(refarr[i].include?('http://'))
            url=refarr[i]
            else
    url=sub_url+refarr[i]
            end
	fourofour=false
	   
		begin
			if(fourofour==false)
			pagina = Nokogiri::HTML(open(url))
			end
            #test for a 404
		rescue Exception =>ex
			puts "got a 404"
			fourofour=true
			retry
		end
		if (fourofour==false)
            #trim it down and remove special characters
		trimval=titlearr[i]
		finval=trimval.gsub!(/[!:\/-]/, '')
        puts titlearr[i]
		if(finval==nil && titlearr[i]!=nil)
		finval=titlearr[i]
		end
		puts finval
		if(finval!=nil)
            #store html from the link with title of the link
            crfile=File.new(('./results'+depth.to_s+"/"+finval+".html").chomp,"w")
    crfile.puts pagina
    crfile.close
	end
	end
        end
end#end for each
    puts "finished"
	end#def crawlscrape

#############################################################################################
   
def Localize(url, depth, sub_url)
    
 #initialize to extract from user view
    @location = Hash.new
    s_depth = depth
    i_page = 0
    prev_ipage = 0
    link_to_add =""
    if (depth<0)
        depth=0
    end
    #open the starting page
page = Nokogiri::HTML(open(url))
    #collect all of the links from the page
links= page.css('a')
    title = page.css('title')
    #initialize variables
refarr=[]
hrefs = []
x=0
    
    #add href to arrays for each link
links.each do |link|
			if(link['href']!=nil && link['href']!="")
			# puts x
			# puts (link['title'].split.join)
			# x+=1
			hrefs.push(link)
				
			end
			
    end
	total=0
    #transfer links to other array
	while(!hrefs.empty?)
		value= hrefs.pop
		refarr.push(value)
		total+=1
	end


    
    #setup for recognition of the end of the array
        refarr.push("-")

if(depth>0)
    
    #create subdirectory for storing current set of scraped pages
    
if (Dir.exist?('./pages'+depth.to_s))
else Dir.mkdir('./pages'+depth.to_s)
end 
    #in each link 
    check = (refarr.length-1)
    for i in 0..check
    if(refarr[i]!="-")
        #evaluate whether link is internal or external
        if(refarr[i]['href']!=nil && refarr[i]['href']!="")
        if(refarr[i]['href'].include?('http://'))
            url=refarr[i]['href']
        else
            url=sub_url+refarr[i]['href']
            #puts "external link"
        end#refarr[i]['href'].include?
        end#refarr[i]['href']!=nil
	fourofour=false
	   
		begin
			if(fourofour==false)
			pagina = Nokogiri::HTML(open(url))
			end
            #test for a 404
		rescue Exception =>ex
			#puts "got a 404"
            #replace href (no navigation onclick)
            refarr[i]['href'] =""
			fourofour=true
              
			retry
        end #begin
        
		if (fourofour==false)
            #make relevant links reference local files
            if(refarr[i]['href']!="" && refarr[i]['href']!=nil)
               
                
                    j_depth = s_depth - depth
                    appendval = "../"
                    clutch = 0
                    for r in 1..j_depth
                        
                        clutch +=1
                    end
                if (Dir.exist?('./pages'+depth.to_s+"/"+clutch.to_s+"set"))
                else Dir.mkdir('./pages'+depth.to_s+"/"+clutch.to_s+"set")
                end 
                if (depth == s_depth)
                   
                    linkref = (('./pages'+depth.to_s+"/"+clutch.to_s+"set/"+i_page.to_s+"x"+i.to_s+"page.html").chomp)
                else
                   
                    linkref = ((appendval+'../pages'+depth.to_s+"/"+clutch.to_s+"set/"+i_page.to_s+"x"+i.to_s+"page.html").chomp)
                end
                pass_a_link = i_page.to_s+"x"+i.to_s+"page.html"
                if (@location.has_key?(refarr[i]['href'])) 
                    loc = @location[(refarr[i]['href'])]
                    sub_loc = loc.match(/(.\/[a-z]{5}\d{1,20}\/\d{1,20}[a-z]{3}\/\d{1,20}[x]\d{1,20}[a-z]{4}.[a-z]{1,20})/)
                   refarr[i]['href'] =sub_loc
                else
                initial_link=refarr[i]['href']
                refarr[i]['href']=linkref
                
                #HERE!!!!!**!*!*@*!!@@***!
                if (depth == s_depth)
                full_link = "../../"+linkref
                else
                    full_link = linkref
                end
                @location[initial_link]=full_link
                #puts "working"
                end# @location.haskey
            end #refarr[i]['href']!=""
            
            #trim it down and remove special characters for display
            trimval=refarr[i]['href']
		finval=trimval.gsub!(/[!:\/-]/, '')
        #puts refarr[i]
        if(finval==nil && refarr[i]!=nil)
        finval=refarr[i]
		end #finval == nil
		
            n_depth = depth-1
          
		if(finval!=nil)
            self. FLocalize(url, n_depth, sub_url, s_depth, i, i_page, pass_a_link)
            #create subdirectory for storing current links page
#if (Dir.exist?('./pages'+depth.to_s+'/link'+i.to_s))
#else Dir.mkdir('./pages'+depth.to_s+'/link'+i.to_s)
#end
            
       
            
                
	end #finval!=nil
        end #fourofour==false
    end #refarr[i]!="-"
    
end#end for each


   
    
else#<< depth not > 0
    check = (refarr.length-1)
    for i in 0..check
        if (refarr[i]['href']!=nil && refarr[i]['href']!="")
        refarr[i]['href']=""
        end
    end
end

if (depth == s_depth)
#store newly generated html/links for current page
mainpage =File.new('./page.html',"w")    
mainpage.puts page
mainpage.close


else
#store page from the link in the subdirectory 
    puts "page: "
    p_depth = depth +1
     j_depth = s_depth - depth
                    appendval = ""
                    clutch = 0
                    for r in 1..j_depth
                        appendval += "../" 
                        clutch +=1
                    end
    clutch -=1
   
    crfile=File.new(('./pages'+p_depth.to_s+"/"+clutch.to_s+"set/"+link_to_add),"w")
            crfile.puts page
            crfile.close
    
end
end #end def Localize

#########################################################################################
def FLocalize(url, depth, sub_url, s_depth, i_page, prev_ipage, link_to_add)
    #open the starting page
 
    if (depth<0)
        depth=0
    end
page = Nokogiri::HTML(open(url))
    #collect all of the links from the page
links= page.css('a')
    title = page.css('title')
    #initialize variables
refarr=[]
hrefs = []
x=0
    
    #add href to arrays for each link
links.each do |link|
			if(link['href']!=nil && link['href']!="")
			# puts x
			# puts (link['title'].split.join)
			# x+=1
			hrefs.push(link)
				
			end
			
    end
	total=0
    #transfer links to other array
	while(!hrefs.empty?)
		value= hrefs.pop
		refarr.push(value)
		total+=1
	end


    
    #setup for recognition of the end of the array
        refarr.push("-")

if(depth>0)
    
    #create subdirectory for storing current set of scraped pages
   
if (Dir.exist?('./pages'+depth.to_s))
else Dir.mkdir('./pages'+depth.to_s)
end 
    #in each link 
    check = (refarr.length-1)
    for i in 0..check
    if(refarr[i]!="-")
        #evaluate whether link is internal or external
        if(refarr[i]['href']!=nil && refarr[i]['href']!="")
        if(refarr[i]['href'].include?('http://'))
            url=refarr[i]['href']
        else
            url=sub_url+refarr[i]['href']
            #puts "external link"
        end#refarr[i]['href'].include?
        end#refarr[i]['href']!=nil
	fourofour=false
	   
		begin
			if(fourofour==false)
			pagina = Nokogiri::HTML(open(url))
			end
            #test for a 404
		rescue Exception =>ex
			#puts "got a 404"
            #replace href (no navigation onclick)
            refarr[i]['href'] =""
			fourofour=true
              
			retry
        end #begin
        
		if (fourofour==false)
            #make relevant links reference local files
            if(refarr[i]['href']!="" && refarr[i]['href']!=nil)
                
                
                    j_depth = s_depth - depth
                    appendval = "../"
                    clutch = 0
                    for r in 1..j_depth
                        
                        clutch +=1
                    end
                if (Dir.exist?('./pages'+depth.to_s+"/"+clutch.to_s+"set"))
                else Dir.mkdir('./pages'+depth.to_s+"/"+clutch.to_s+"set")
                end 
                    
                    linkref = ((appendval+'../pages'+depth.to_s+"/"+clutch.to_s+"set/"+i_page.to_s+"x"+i.to_s+"page.html"))
              
                pass_a_link = i_page.to_s+"x"+i.to_s+"page.html"
                if (@location.has_key?(refarr[i]['href'])) 
                    pass_a_link = "this_is_a_duplicate"
                    refarr[i]['href'] = @location[(refarr[i]['href'])]
                    
                else
                initial_link=refarr[i]['href']
                refarr[i]['href']=linkref
               
                
                
                    full_link = linkref
             
                @location[initial_link]=linkref
                #puts "working"
                end# @location.haskey
            end #refarr[i]['href']!=""
            
            
            #trim it down and remove special characters for display
            trimval=refarr[i]['href']
		finval=trimval.gsub!(/[!:\/-]/, '')
        #puts refarr[i]
        if(finval==nil && refarr[i]!=nil)
        finval=refarr[i]
		end #finval == nil
		
            n_depth = depth-1
          
		if(finval!=nil)
            self. FLocalize(url, n_depth, sub_url, s_depth, i, i_page, pass_a_link)
           
            
            
                
	end #finval!=nil
        end #fourofour==false
    end #refarr[i]!="-"
    
end#end for each


    
    
else#<< depth not > 0
    check = (refarr.length-1)
    for i in 0..check
        if (refarr[i]['href']!=nil && refarr[i]['href']!="")
        refarr[i]['href']=""
        
        end
    end
end

if (depth == s_depth)
#store newly generated html/links for current page
mainpage =File.new('./page.html',"w")    
mainpage.puts page
mainpage.close


else
#store page from the link in the subdirectory 
   
    p_depth = depth +1
     j_depth = s_depth - depth
                    appendval = ""
                    clutch = 0
                    for r in 1..j_depth
                        appendval += "../" 
                        clutch +=1
                    end
    clutch -=1
   
    if (link_to_add!="this_is_a_duplicate")

    crfile=File.new(('./pages'+p_depth.to_s+"/"+clutch.to_s+"set/"+link_to_add),"w")
            crfile.puts page
            crfile.close
    else
        
    end
    
end
end #end def FLocalize

#########################################################################################

end#module
