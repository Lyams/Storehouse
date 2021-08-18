module StorehousesHelper
  def i18n_array_disrict
    Storehouse.district.values.map{ |n| [ (I18n.t "enumerize.storehouse.district.#{n}") , n] }
  end
end
