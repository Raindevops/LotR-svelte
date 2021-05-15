<script>
    import {onMount} from "svelte";
    import SingleCharacter from "./SingleCharacter.svelte"
    let datas = [];
    let clone = [];

    let raceAr = [];
    let realmAr = [];

    let race;
    let realm;

    onMount(async function () {

        if (localStorage.getItem("characters")) {
            datas = JSON.parse(localStorage.getItem("characters"));
            raceAr = JSON.parse(localStorage.getItem("races"));
            realmAr = JSON.parse(localStorage.getItem("realms"));
            return;
        }
        const request = await fetch(`${__lotr.env.API_URL}/character`,{
            headers: {
                method: "GET",
                Authorization: `Bearer ${__lotr.env.API_TOKEN}`,
            },
        })
        .then(response => response.json())
        .then(data => {
            datas = data.docs;
            raceAr = fillSelects(datas).race;
            realmAr = fillSelects(datas).realm;
            localStorage.setItem("characters", JSON.stringify(data.docs));
            localStorage.setItem("races",JSON.stringify(raceAr));
            localStorage.setItem("realms",JSON.stringify(realmAr));
        });

    });

    const fillSelects = datas => {
        let raceArr = [];
        let realmArr = [];
        datas.map(d => {
            if (!raceArr.includes(d.race) && (d.race !== "NaN" && d.race.length > 0)) {
                raceArr.push(d.race);
            }
            if (!realmArr.includes(d.realm) && (d.realm !== "NaN" && d.realm.length > 0)) {
                realmArr.push(d.realm);
            }
        });
        raceArr = sortDatas(raceArr);
        realmArr = sortDatas(realmArr);
        return {
            "race": raceArr,
            "realm": realmArr
        }
    }

    const sortDatas = (datas) => {
        datas.sort(function(a,b){
            if (a > b) {return 1}
            if (a < b) {return -1}
        });
        return datas;
    }

    const onSelectChange = _ => {
        let array = [];
        datas.map(el => {
            if (el.race === _.target.value) {
                array.push(el);
            }
            if (el.realm === _.target.value){
                array.push(el)
            }
        });
        raceAr = fillSelects(array).race;
        realmAr = fillSelects(array).realm;
        return clone = array;
    }

    const resetSelects = () => {
        raceAr = fillSelects(datas).race;
        realmAr = fillSelects(datas).realm;
        return clone = [];
    }
    
</script>

<main>
    <div class="characters-background">
        <img src="../assets/old-book.jpg" alt="old book">
    </div>
    <h2>Discover famous characters from Tolkien's universe</h2>
    {#if datas}
        {#await datas}
            <p>Is loading</p>
            {:then datas} 
            <div class="content">
                <div class="character-research">
                    <div class="character-research--race">
                        <span>Select a race</span>
                        <select value={race} name="race" on:change={onSelectChange.bind(race)}>
                            {#each raceAr as race}
                                <option value={race}>{race}</option>
                            {/each}
                        </select>
                    </div>
                    <div class="character-research--realm">
                        <span>Select a realm</span>
                        <select value={realm} name="realm"  on:change={onSelectChange.bind(realm)}>
                            {#each realmAr as realm}
                                <option value={realm}>{realm}</option>
                            {/each}
                        </select>
                    </div>
                    <button on:click={resetSelects}>Reset filters</button>
                </div>
    
                {#if clone.length > 0}
                    <div class="characters">
                        {#each clone as character }
                            <SingleCharacter character={character}/>
                        {/each}
                    </div>
                {/if}
            </div>
        {/await}
    {/if}
</main>

<style type="text/scss">
    $gold : #C4B479;
    .characters-background{
        position: fixed;
        top:0;
        left:0;
        width: 100vw;
        height: 100vh;
        z-index: -1;
        img{
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: .2;
            filter: saturate(.7);
        }
    }
    .character-research{
        display: grid;
        grid-template-columns: repeat(2fr, 1fr);
        grid-gap: 1rem;
        align-items: end;
        text-align: left;
        margin-bottom: 2rem;
        &--race{
            grid-column: 1;
        }&--realm{
            grid-column: 2/4;
        }
        button{
            grid-column: 4;
        }
        span{
	        font-family: "Darleston";
            color: $gold;
            display: block;
            font-size: 1.5em;
        }
        select{
            width: 100%;
        }
    }
    .characters{
        display: grid;
        grid-gap: 1rem;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        text-align: left;
    }
</style>