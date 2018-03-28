class FlashCard
  class Repo
    attr_reader :errors, :flash_card

    def initialize(params:, creator:)
      @params = params
      @creator = creator
      @category = params[:category_id]
      @flash_card = nil
      @flash_card_show = nil
      @errors = Array.new
    end

    def execute
      begin
        FlashCard.transaction do
          @flash_card = creator.flash_cards.new(params)
          set_category!(flash_card)

          if flash_card.save
            @flash_card_show = flash_card.flash_card_shows.create(user: creator)
          else
            raise ActiveRecord::Rollback
          end
        end
      rescue ActiveRecord::Rollback
        @errors << flash_card.errors if flash_card.errors.present?
        @errors << flash_card_show.errors if flash_card_show.errors.present?
      end

      self
    end

    private

    attr_reader :params,
                :creator,
                :category,
                :flash_card_show


    def set_category!(flash_card)
      if flash_card.category_id.nil?
        flash_card.category = creator.categories.find_by_is_default(true) || creator.categories.create(name: "General", is_default: true)
      end
    end
  end
end
