<script>
    import {onMount} from 'svelte';

    let quotes = [];

    onMount(async function() {
        if (localStorage.getItem("quotes")){
            quotes = JSON.parse(localStorage.getItem("quotes"));
            return
        }

       const request = await fetch(`${__lotr.env.API_URL}/quote`,{
           headers: {
               method: "GET",
               Authorization: `Bearer ${__lotr.env.API_TOKEN}`,
           },
       })
       .then(response => response.json())
       .then(data => {
            quotes = data.docs
            localStorage.setItem("quotes",JSON.stringify(quotes));
        });
    });
</script>

<main>
    <h1>Quotes section</h1>
    {#if quotes !== undefined}

        {#await quotes}
            {:then quotes}
            {#each quotes as quote }
                <p>{quote.dialog}</p>
            {/each}
        {/await}

    {/if}
</main>

<style type="text/scss">
</style>