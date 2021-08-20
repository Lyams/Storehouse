module StorehousesHelper
  def i18n_array_disrict
    Storehouse.district.values.map{ |n| [ (I18n.t "enumerize.storehouse.district.#{n}") , n] }
  end

  def date_of_last_delivery(storehouse, thing)
    deliveries = storehouse&.deliveries
    deliveries.filter{ |d|  d.things.map(&:commodity).include?(thing.commodity) }&.map(&:date_of_delivery).compact.max
  end
end
