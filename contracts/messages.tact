const minTonForStorage: Int = ton("0.03");
const gasConsumption: Int = ton("0.03");

message CreateCollection{
    collectionContent: String;
}

message MintCollection{
    nftCollectionIndex: Int as uint32;
    nftItemContent: String;
    
}

message ListingNft{
    marketplaceFee: Int as uint32;
    royaltyFee: Int as uint32;
    expiredDate: Int as uint32;
    ownerAddress: Address;
    expectedPrice: Int as coins;
    nftAddress: Address;

}

message SucceedListing{
    listingAddress: Address;
}

message OwnershipAssigned{
    query_id: Int as uint64;
    prev_owner: Address;
    forward_payload: Cell;
}

message OfferComplete{
    offerAddress: Address;
    nftAddress: Address;
}

message Transfer{
    query_id: Int as uint64;
    new_owner: Address;
    response_destination: Address;
    custom_payload: Cell;
    forward_amount: Int as uint16;
    forward_payload: Cell;
}

message AllowAuction{
    offerAddress: Address;
}

message Mint{

}

