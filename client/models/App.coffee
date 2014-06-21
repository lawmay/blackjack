#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'inPlay', true
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', =>
      if @get('inPlay')
        @get('dealerHand').models[0].flip()
        @get('dealerHand').hit() while @get('dealerHand').scores() < 17
      if @get('dealerHand').scores() > @get('playerHand').scores()
        console.log("Dealer Wins")
      else
        console.log("Player Wins")
      @trigger('gameOver')

    @get('playerHand').on 'bust', =>
      @trigger "playerBusted"
      @set 'inPlay', false
      console.log(@get('inPlay'))
    @get('dealerHand').on 'bust', =>
      @trigger "dealerBusted"
      @set 'inPlay', false
    @
