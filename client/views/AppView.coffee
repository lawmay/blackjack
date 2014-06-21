class window.AppView extends Backbone.View

  template: _.template '
    <div class="result"></div>
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="new-game-button">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game-button": -> @model.initialize(); console.log @; @render()

  disableButtons: =>
    @$('.stand-button').attr('disabled', 'disabled')
    @$('.hit-button').attr('disabled', 'disabled')

  playerBust : =>
    @$('.result').html('')
    @$('.result').append("Player Busted!")
    @disableButtons()

  dealerBust : =>
    @$('.result').html('')
    @$('.result').append("Dealer Busted!")
    @disableButtons()
  initialize: ->
    @render()
    @$('.result').html('')
    @model.on "playerBusted", => @playerBust()
    @model.on "dealerBusted", => @dealerBust()
    @model.on "roundOver", => @disableButtons()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
