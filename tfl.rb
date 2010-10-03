class Tfl
  
  def self.find_results(starts,ends)
    a = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }

    a.get('http://wap.tfl.gov.uk/home/') do |page|
      from = a.click(page.link_with(:text => /Plan journey/))

      to = from.form_with(:action => /^\/planner\/.*/) do |form|
        form.from = starts
      end.submit
    
      route = to.form_with(:action => /^\/planner\/.*/) do |form|
        form.to = ends
      end.submit
      
      result = route.links.first.click
      return result.body.gsub('/kcml','')
    end    
  end
end