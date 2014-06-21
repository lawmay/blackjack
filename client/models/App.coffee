#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', =>
      @get('dealerHand').models[0].flip()
      @get('dealerHand').hit() while @get('dealerHand').scores() < 17
      console.log @get('dealerHand').scores()
    console.log @
    @get('playerHand').on 'bust', =>
      @trigger "playerBusted"
      console.log 'player hand busted'
    @get('dealerHand').on 'bust', =>
      console.log 'dealer hand busted'
    @
