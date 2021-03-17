<script>
    import {onMount} from 'svelte';

    export let book;
    let chapters = [];

    onMount(async function(){

        if (localStorage.getItem(`bookID-${book._id}`)) {
            chapters = JSON.parse(localStorage.getItem(`bookID-${book._id}`))
        }

        const req = await fetch(`${__lotr.env.API_URL}/book/${book._id}/chapter`)
        .then(resp => resp.json())
        .then(data=> {
            chapters = data.docs
            localStorage.setItem(`bookID-${book._id}`, JSON.stringify(chapters))
        });

    });
</script>
    <h3>{book.name}</h3>
    {#if chapters != undefined}

        {#await chapters}
            <p>loading</p>
        {:then chapters}
        
            {#each chapters as chap }
                <p>{chap.chapterName}</p>
            {/each}
            
        {/await}

    {/if}
<style>

</style>