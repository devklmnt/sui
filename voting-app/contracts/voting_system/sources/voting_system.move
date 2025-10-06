// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

/// Module: dashboard
module voting_system::dashboard; // PackageAddress::ModuleName

use std::string::String;


// key is ability
public struct Proposal has key {
    id: UID,
    title: String,
    description: String,
    voted_yes_count: u64,
    voted_no_count: u64,
    expiration: u64,
    creator: address,
    voter_registry: vector<address>
}


public fun create_proposal(
    title: String,
    description: String,
    expiration: u64,
    ctx: &mut TxContext
){
    let proposal = Proposal {
        id: object::new(ctx),
        title,
        description,
        voted_yes_count: 0,
        voted_no_count: 0,
        expiration,
        creator: tx_context::sender(ctx),
        voter_registry: vector::empty<address>()
    };
    transfer::share_object(proposal);
}