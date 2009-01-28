class Reports < Thor                                             
  require 'db'
  
  desc 'city_comparison', 'show a breakdown by city'
  def city_comparison
    test = repository(:default).adapter.query(<<-SQL
      SELECT age, SUM(result) as base, 
      (SELECT SUM(result) FROM stats WHERE zipcode = s1.zipcode AND age = s1.age AND 
      (scrape='smokers' OR scrape='heavy_smokers')) as smokers, (SELECT SUM(result) 
      FROM stats WHERE zipcode = s1.zipcode AND age = s1.age AND 
      (scrape='drinkers' OR scrape='heavy_drinkers')) as drinkers, 
      (SELECT SUM(result) FROM stats WHERE zipcode = s1.zipcode AND age = s1.age AND 
      (scrape='drugs' OR scrape='heavy_drugs')) as drugs FROM stats as s1 WHERE zipcode='30309' 
      GROUP BY age;
      SQL
    )
    p test[0].base
  end
  
end
