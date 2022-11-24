<script>
  let isOpen = false;

  export let title;

  let trigger;

  function onClick(event) {
    if (isOpen && !trigger?.contains(event.target)) {
      isOpen = false;
    }
  }

  document.body.addEventListener("click", onClick);
</script>

<div class="dropdown">
  <button
    class="trigger"
    class:open={isOpen}
    type="button"
    on:click={() => (isOpen = !isOpen)}
    bind:this={trigger}
  >
    {title} <img class="caret" src="/assets/caret-down.svg" alt="" />
  </button>
  {#if isOpen}
    <div class="menu">
      <slot />
    </div>
  {/if}
</div>

<style>
  .dropdown {
    position: relative;
    display: inline-block;
  }

  .trigger {
    all: unset;
    cursor: pointer;
    padding: 0.5em;
    border: solid 1px transparent;
  }
  .trigger:focus {
    outline: orange 5px auto;
  }
  .trigger.open {
    border-color: var(--border-color);
    border-radius: 5px 5px 0 5px;
  }

  .caret {
    width: 16px;
    vertical-align: sub;
  }

  .menu {
    position: absolute;
    right: 0;
    padding: 0.5em 0;
    background-color: var(--background-color);
    border: solid 1px var(--border-color);
    border-radius: 0 0 5px 5px;
    transform: translateY(-1px);
  }
</style>
