defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Marvin's Cabin</h1>
    <div id="light">
      <div class="meter" style="padding-left: 2px;">
        <span style="width: <%= @brightness %>%">
          <%= @brightness %>%
        </span>
      </div>
      <button phx-click="off">
        <img src="images/light-off.svg">
        Off
      </button>

      <button phx-click="down">
        <img src="images/down.svg">
        Dim
      </button>

      <button phx-click="up">
        <img src="images/up.svg">
        Brighten
      </button>

      <button phx-click="on">
        <img src="images/light-on.svg">
        On
      </button>

      <button phx-click="shine">
        <img src="images/refresh.svg">
        Shine
      </button>

    </div>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("shine", _, socket) do
    socket = assign(socket, :brightness, Enum.random(0..100))
    {:noreply, socket}
  end

end
