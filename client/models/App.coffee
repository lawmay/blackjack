#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: =>
    @set 'inPlay', true
    @set 'deck', deck = new Deck()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerHand', deck.dealPlayer()

    @get('playerHand').on 'stand', =>
      if @get('inPlay')
        @get('dealerHand').models[0].flip()
        @get('dealerHand').hit() while @get('dealerHand').scores() < 17
      if @get('dealerHand').scores() > @get('playerHand').scores() and @get('dealerHand').scores() <= 21
        @trigger("dealerWin")
      else if @get('dealerHand').scores() is @get('playerHand').scores()
        @trigger('tie')
      else
        @trigger("playerWin")
      @trigger('roundOver')

    @get('playerHand').on 'bust', =>
      # @set 'inPlay', false
      @trigger('dealerWin')
    @

  checkInstaWin: =>
    if @get('playerHand').scores() == 21
      @trigger('playerWin')
      # setTimeout(@trigger('playerWin'), 1000).bind(@)
