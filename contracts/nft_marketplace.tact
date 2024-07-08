import "@stdlib/deploy";
import "@stdlib/ownable";
import "./messages.tact";
import "./nft_offer.tact";
import "./nft_collection.tact";

contract NftMarketplace with Deployable, Ownable {
    // Empty init() function is present by default in all Tact contracts
    // since v1.3.0, so{} the following may be omitted:
    //
    // init() {}
    owner: Address;
    nextListingIndex: Int as uint32 ;
    nextCollectionIndex: Int as uint32;

    init(){
        self.owner=sender();    
        self.nextListingIndex = 0;
        self.nextCollectionIndex = 0;
    }

    // receive(msg: CreateCollection){
    //      self.requireOwner();
    //      let NftCollectionInit: StateInit = initOf NftCollection(myAddress(),CreateCollection.collectionContent,self.nextCollectionIndex);
        
    //      send(SendParameters{
    //         to: contractAddress(nftCollectionInit),
    //         value: ton("0.1"),
    //         mode: SendIgnoreErrors,
    //         bounce: false,  
    //         body: "deploy".asComment(),
    //         code: nftItemInit.code,
    //         data: nftItemInit.data

    // }); 
    //     self.nextCollectionIndex = self.nextCollectionIndex+1;
    // }

    receive(msg: MintCollection){
        self.requireOwner();
    }

    receive(msg: ListingNft){
        require(context().value>=minTonForStorage+2*gasConsumption, "not enough fee");
        let nftOfferInit: StateInit = initOf NftOffer(myAddress(),msg.royaltyFee,msg.expiredDate,sender(),msg.expectedPrice,msg.nftAddress);
        
        send(SendParameters{
            to: contractAddress(nftOfferInit),
            value: minTonForStorage,
            mode: SendPayGasSeparately+SendIgnoreErrors,
            bounce: false,  
            body: "deploy".asComment(),
            code: nftOfferInit.code,         
            data: nftOfferInit.data
    }); 
        
        send(SendParameters{
            to: sender(),
            value: 0,
            mode: SendRemainingValue+SendIgnoreErrors,
            bounce:true,
            body: SucceedListing{
                listingAddress: contractAddress(nftOfferInit)
            }.toCell()
        })
    }

    // receive(msg: StakeNft){
        
    // }

    receive(msg: AllowAuction){
        send(SendParameters{
            to: msg.offerAddress,
            value: ton("0.1"),
            mode: SendIgnoreErrors,
            bounce: false,  
            body: "allowAuction".asComment(),
        })
    }

    // receive(msg: AllowWhitelist){

    // }

    // receive(msg: AddWhiteList){
        
    // }

    // receive(msg: StakeNft){
        
    // }

    fun createOffer(){
        
    }

}
