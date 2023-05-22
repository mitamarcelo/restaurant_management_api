class Menu < ApplicationRecord
  belongs_to :restaurant

  def toggle_active_menu!
    update!(active: !active)
  end
end
