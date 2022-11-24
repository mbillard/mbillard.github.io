<script>
  import { clickOutside } from "../helpers/clickOutside";

  let isOpen = false;

  export let title;
</script>

<div class="dropdown">
  <button
    class="trigger"
    class:open={isOpen}
    type="button"
    on:click={() => (isOpen = !isOpen)}
    use:clickOutside
    on:outclick={() => (isOpen = false)}
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
