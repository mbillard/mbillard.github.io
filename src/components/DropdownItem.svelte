<script>
  export let url;
</script>

<a href={url}><slot /></a>

<style>
  a {
    display: block;
    padding: 0.5em;
    text-decoration: none;
    color: black;
  }
  a:hover {
    background-color: var(--hover-color);
  }
</style>
